Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41E25ECD.2000505@fcse.co.uk>
From: Jeff Fern <sf@fcse.co.uk>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] Multiple Headsets
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
Date: Mon, 10 Jan 2005 10:54:05 +0000

Hello all,

I have sucessfully got Bluez and the bt-snd-sco alsa stuff working with 
my debian 2.6.9 and mh5 patch.

What I would like to do is get two headsets working, as two seperate 
audio devices so I can cat /dev/dsp1 to /dev/dsp2 and pass audio through.

Whenever I currently try and connect two headsets, the second one 
reports the SCO channel is already in use.

I do have two bluetooth USB dongles that can be used (although would 
like to just use one if possible).

I should point out that my background is in Java and not C, so although 
I have examined the bt-snd-sco and btsco source files, I do not 
understand them enough to be able to see what is going on.

Any help would be much appreciated,

Regards,

-Jeff Fern


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
