Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4658713F.1020401@idlum.be>
Date: Sat, 26 May 2007 19:41:19 +0200
From: Pierre-Yves Paulus <py@idlum.be>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <46580A33.3030701@idlum.be>
	<1180177290.21432.42.camel@aeonflux.holtmann.net>
In-Reply-To: <1180177290.21432.42.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] New Serial DBus API - how to choose dongle used?
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

Hi Marcel,

>> RFCOMM: String ConnectByChannel(String address, byte channel);
>> Serial: No equivalent so far
> 
> simply use ConnectService(<bdaddr>, channel). The pattern matching works
> the that if you give a decimal number that it connects to the specified
> channel.

Nice!

>> So, my question: how do I choose which dongle to use to perform the 
>> connection with the new implementation, in case several are connected to 
>> the system?
> 
> We don't support this. At least not yet. At some point, we might have
> additional methods that let you choose a source address. However that is
> not our priority at the moment.

Ouch, bad luck for me. I hope I'll have time to see if I can add this 
functionnality myself, as I definitely need it. Don't know however if I 
don't lack the ability and knowledge, as I never worked inside BlueZ 
source. How would you rate the difficulty of the work involved to 
implement such a behaviour?

At the moment, the current "no choice" implementation simply always use 
hci0?


Best Regards,
Pierre-Yves

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
