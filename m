Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: John Gruenenfelder <johng@as.arizona.edu>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Problem with link keys
Message-ID: <20050806090723.GA13065@as.arizona.edu>
References: <20050806030119.GA10008@as.arizona.edu> <1123301455.26693.4.camel@pegasus> <20050806050145.GA11152@as.arizona.edu> <1123304874.7296.3.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1123304874.7296.3.camel@pegasus>
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
Date: Sat, 6 Aug 2005 02:07:23 -0700

On Sat, Aug 06, 2005 at 07:07:53AM +0200, Marcel Holtmann wrote:
>> And it is working just fine.  It only seems to misbehave when I power it off.
>> Are any other people on this list using a Plantronics M2500 headset and, if
>> so, are you experiencing anything similar?
>
>I see always a authentication failure in your log. This means you never
>succeeded with your command or you send the wrong log. However the usage
>of "hcitool cc ..." doesn't qualifies for a correct headset/handsfree
>profile setup and thus your headset may forget your link key. Use tools
>like hstest of btsco and try again.
>
>Regards
>
>Marcel

Ah yes, that was it exactly.  It's now working very well, even after powering
on and off.

Now that it is working reliably, I just have two more minor questions about
btsco:

1) Is there any way to have btsco started when I turn on the headset?  hcid
   sees this event, but I did not see anything in the hcid.conf manpage for
   launching processes.

2) btsco allows for creating a .btsco file with regex in it so that you can
   make it do something on a button press.  How do I learn what those regex
   should be for my particular headset?  Is it part of one of the packets
   dumped by hcidump?

Thanks again for all the help!


-- 
--John Gruenenfelder    Research Assistant, Steward Observatory, U of Arizona
                        johng@as.arizona.edu
Try Weasel Reader for PalmOS  --  http://gutenpalm.sf.net
"This is the most fun I've had without being drenched in the blood
of my enemies!"
        --Sam of Sam & Max


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
