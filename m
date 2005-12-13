Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <439EC385.6000403@service2media.com>
From: Herman Meerlo <herman@service2media.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Setting up two connections at the same time
References: <439E98E4.4010800@service2media.com>	 <1134471824.29210.20.camel@blade>  <439EB8C4.1080206@service2media.com>	 <1134476254.29210.39.camel@blade>  <439EBE63.1050006@service2media.com> <1134477743.29210.52.camel@blade>
In-Reply-To: <1134477743.29210.52.camel@blade>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 13 Dec 2005 13:50:13 +0100

Hi Marcel,


>>>>thanks for your reply. It is not only a problem if one single 
>>>>application tries to set-up multiple connections simultaneously, it will 
>>>>also fail if two independent applications on one machine try to setup a 
>>>>connection. This makes bluetooth an unreliable medium from an end-user 
>>>>perspective because connection set-up may fail randomly because of this. 
>>>>This will off course not happen extremely often. However I think that 
>>>>this problem could be solved at HCI level which can keep track of the 
>>>>controller state. E.g. it could hold up any Connection Request until the 
>>>>previous one has finished. Or am I missing something?
>>>>        
>>>>
>>>feel free to propose something to support this. However this must be
>>>done at kernel level in the Bluetooth core HCI functions.
>>>      
>>>
>>I was afraid you were going to say this :-) I completely agree with you 
>>and I hope my boss will give me the time to think about this and let me 
>>make a prototype. In the meantime I will probably try to workaround this 
>>with multiple dongles.
>>    
>>
>
>and btw you will see similar problems with inquiry and remote name
>requests at the same time. You might need to serialize all of them.
>
>An interesting question is how any of Windows stacks handles this? Are
>they capable of dealing with it or do they act like Linux?
>
>
>  
>
two minds, one thought. I was thinking exactly the same. I did indeed 
see the same problems with remote name requests (I already serialized 
the inquiry process in my application). Maybe I will try to make a test 
set-up for this to see how windows behaves.

Regards,

Herman


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
