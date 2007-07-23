Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Mon, 23 Jul 2007 14:43:09 -0400
From: Dave Mielke <dave@mielke.cc>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20070723184309.GP11031@beta.private.mielke.cc>
References: <20070723174905.GO11031@beta.private.mielke.cc>
	<1185213219.7111.48.camel@violet>
Mime-Version: 1.0
In-Reply-To: <1185213219.7111.48.camel@violet>
Subject: Re: [Bluez-devel] Setting a PIN without a GUI.
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

[quoted lines by Marcel Holtmann on 2007/07/23 at 19:53 +0200]

>you have to provide a passkey agent that will handle the PIN request.
>The bluez-utils source contains an example passkey-agent.c that we used
>for testing.

Can a variant of that tool run as a thread which lives for the duration of the
connect attempt? If so, does it need to stay running until the close or can it
be terminated as soon as the connect succeeds?

I tried to compile it with -I/usr/include/dbus-1.0 and -I/usr/lib/dbus-1.0, and
still got VERSION not defined.

Is there a tool which should give me the right compile and link flags?

-- 
Dave Mielke           | 2213 Fox Crescent | I believe that the Bible is the
Phone: 1-613-726-0014 | Ottawa, Ontario   | Word of God. Please contact me
EMail: dave@mielke.cc | Canada  K2A 1H7   | if you're concerned about Hell.
http://FamilyRadio.com/                   | http://Mielke.cc/bible/

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
