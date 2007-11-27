Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <474BF69A.3030008@infitsrl.com>
Date: Tue, 27 Nov 2007 11:51:06 +0100
From: Fabrizio Guglielmino <guglielmino@infitsrl.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <5E13F596-B867-4C0D-9795-97D93507474C@infitsrl.com>
	<1196151954.17196.15.camel@aeonflux>
In-Reply-To: <1196151954.17196.15.camel@aeonflux>
Subject: Re: [Bluez-devel] Scan and push images
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Marcel Holtmann ha scritto:
> Hi Fabrizio,
>
> if you wanna get any real attention on this mailing list, you better
> fill in a subject. I tend to quickly delete messages without a subject.
>
>   
>> I made a simple software to send small pictures to all bluetooth  
>> devices in range (it's used by a museum ).
>> This software is made in C using bluez api, I've used two bluetooth  
>> dongles : one to make periodic inquiry (not with HCI periodic inquiry  
>> command by with a loop) and the other to make sdp query looking for  
>> obex push service and sending image.
>> My requirement was to use this software in some embedded linux based  
>> computer so I chose to limit external library, I made all using  
>> pthread so there is an infinite thread for inquiries and one thread  
>> to handle every sdp query and relative connection when devices are  
>> discovered. I've discarded also using python or other scripting  
>> languages for the platfom limitations.
>>
>> All works but I found it not so efficient, also with 6/7 devices it's  
>> really slow to identify and connect to devices, some times connection  
>> are unexpectedly closed and so on....
>>     
>
> A lot of people tried to make this work and there are ways to make it
> work as efficient as possible. However you need an understanding on how
> the Bluetooth radio and baseband are working and what the limits are.
> For example using one or two threads doesn't give anything useful. This
> is the wrong approach to start with. No excuses. You are simply blocking
> the baseband with your random attempts. It is also better to use
> periodic inquiry or explicitly cancel an inquiry when you wanna page the
> remote device for a SDP query. It also makes sense to use the class of
> device to a pre-filter on remote devices that actually support object
> transfer.
>
> Run a "hcidump -X -V" during your scans and connect attempts and you see
> the errors that will present themself when you try to page during an
> inquiry. The kernel taIs it my approch to the problem wrong or bluetooth protocol is not  
> suitable for this type of use?
>   
>
> Do you have any choice when it comes to communicate with mobile phones?
>
>   
>> I'm using libs version 3.7-1 (on debian 4.0)
>>     
>
> The latest version is 3.22 :)
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2005.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>   

Ok for the subject, excuse me.

I can't undertand "You are simply blocking the baseband with your random 
attempts", where are the random attemps?
One thread is dedicated to make inquiry, it bind on a specific local 
adapter and make an infinite loop of inquiry (with a parametric sleep on 
every iteration).

On the other side for every device discovered it's lauched a thread for 
these operations:
1) sdp query for OPUSH service (serialized with a mutex)
2) connection to eventually discovered RFCOMM channel of the object push 
service
3) push of the content (with my own working obex implementation)

I'd like to accept Your suggests but:
- If I use periodic inquiry I need obligatory dbus to  receive callback 
events?
- How can I perform pre-filter on remote devices that support object 
transfer if I've not discovered their servies?

About library version I known I'm a little outdated ;-) but I'm 
preparing a new working environment with latest version.

Many thanks
Fabrizio

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
