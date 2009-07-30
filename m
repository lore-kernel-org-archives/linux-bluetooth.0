Return-Path: <cyrus@holtmann.org>
Message-ID: <4A712E82.40303@xyzw.org>
Date: Wed, 29 Jul 2009 22:24:18 -0700
From: Brian Rogers <brian@xyzw.org>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>,
 David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Wait for child devices to go away before deleting a connection
References: <4A6424D8.3040306@xyzw.org> <1248077430.4549.97.camel@violet>	 <4A6864DE.5010501@xyzw.org> <1248901964.28545.242.camel@violet>	 <4A70CF45.1060706@xyzw.org> <1248921191.28545.251.camel@violet>	 <4A711294.5010901@xyzw.org> <1248925752.28545.260.camel@violet>
In-Reply-To: <1248925752.28545.260.camel@violet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel Holtmann wrote:
> Hi Brian,
>
>   
>>>>>>> Kay, David, wouldn't be pinning of the parent device here be enough to
>>>>>>> get this done in a clean way?
>>>>>>>   
>>>>>>>       
>>>>>>>           
>>>>>>>               
>>>>>> If there's a way that the connection can be pinned until the child 
>>>>>> devices go away, that definitely sounds cleaner to me.
>>>>>>     
>>>>>>         
>>>>>>             
>>>>> so I pushed some patches to bluetooth-testing tree that should fix this
>>>>> problem. They are not fully tested by me. Please test and report back
>>>>> the results.
>>>>>   
>>>>>       
>>>>>           
>>>> Fails to compile if CONFIG_USB_HIDDEV=y :
>>>>
>>>> ERROR: "hiddev_disconnect" [net/bluetooth/hidp/hidp.ko] undefined!
>>>>
>>>> Ironically, the reference to hiddev_disconnect is fine if hiddev isn't 
>>>> enabled because then hiddev.h supplies an empty static inline function.
>>>>
>>>> I'm going to test with a kernel without hiddev for now.
>>>>     
>>>>         
>>> just take that piece out of the patch. It is not important. I just wanna
>>> now if the uevents are now coming in order.
>>>   
>>>       
>> I just tried it without hiddev and observed that the input devices go 
>> away, but the connection never gets deleted. Then when I turn my mouse 
>> back on, bad stuff happens:
>>     
>
> I do have a typo here :(
>
> 	void hci_conn_hold_device(struct hci_conn *conn)
> 	{
> 	        hci_conn_hold(conn);
>
> 	        atomic_inc(&conn->devref);
> 	}
> 	EXPORT_SYMBOL(hci_conn_hold_device);
>
> 	void hci_conn_put_device(struct hci_conn *conn)
> 	{
> 	        if (atomic_dec_and_test(&conn->refcnt))
>         	        hci_conn_del_sysfs(conn);
>
>         	hci_conn_put(conn);
> 	}
> 	EXPORT_SYMBOL(hci_conn_put_device);
>
> The atomic_dec_and_test() should operate on conn->devref. Can you change
> that and try again.
>   

That got it to work once, but it was apparently a fluke because my the 
next two times I tried shutting off my mouse, it caused a complete 
system freeze where Alt-SysRq B didn't work.

> Also if that doesn't help, remove the hci_conn_hold() and hci_conn_put()
> from the two functions above and try again.
>   

That did the trick. Now I see correct device removal order and I haven't 
observed any problems with switching my mouse on and off.
