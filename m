Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <428DEFF0.3050101@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Creating more than one instance of BlueZ
References: <20050520075738.73600.qmail@web8308.mail.in.yahoo.com>
In-Reply-To: <20050520075738.73600.qmail@web8308.mail.in.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Fri, 20 May 2005 08:10:56 -0600

Mayank,

if you run "hciconfig" with two adapters connected, you see both hci0 
and hci1. you also see their bdaddrs.

iirc, when you create a bt socket we usually set "any" as the source 
(remember setting local_addr with bacpy(&local_addr, BDADDR_ANY) in 
a2recv.c). you can use a specific adapter and that is what you have to 
do when you have two adapters and you want to go out on a specific one.

when you connect to a service, obviously you can specify the bdaddress 
to connect to.

most of the core bluez code will allow you to set the src address using 
command-line arguments (a good example is -i <hciX|bdaddr> in hidd) but 
we've been lazy in the btsco code about that.

brad

Mayank Batra wrote:
> Brad,
> 
> 
>>I think the best you can expect is for bluez to see
>>hci0 and hci1. then 
>>you've got to make sure your apps choose the right
>>adapter.
>>
>>
> 
> 
> That is not possible since we have only one set of
> modules for l2cap, rfcomm, bnep etc.
> 
> So even if I tell my app to use which adapter, only
> one app will have exclusive access to the modules.
> And the other app will be waiting for the first app to
> free the modules.
> 
> A deadlock!
> 
> Mayank
> 
> ________________________________________________________________________
> Yahoo! India Matrimony: Find your life partner online
> Go to: http://yahoo.shaadi.com/india-matrimony
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by Oracle Space Sweepstakes
> Want to be the first software developer in space?
> Enter now for the Oracle Space Sweepstakes!
> http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
