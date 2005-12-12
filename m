Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] UART bluetooth chip problem
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <7846f1440512121021s65b57be7g30673fa6090df057@mail.gmail.com>
References: <7846f1440512071711x6c56c8er24edb8e3a8815ab9@mail.gmail.com>
	 <1134020677.3752.61.camel@blade>
	 <7846f1440512081019g4bbf588cta4f4d395b7be0d74@mail.gmail.com>
	 <1134074044.17592.13.camel@blade>
	 <7846f1440512081510w4ffff8cdoe25ae369e677144@mail.gmail.com>
	 <1134087822.17592.44.camel@blade>
	 <7846f1440512090946n58fbf3e8gfecd3ebeb270bf58@mail.gmail.com>
	 <1134154036.10644.18.camel@blade>
	 <7846f1440512091123p5abce553gff0ef4658bc5ee45@mail.gmail.com>
	 <1134158505.10644.22.camel@blade>
	 <7846f1440512121021s65b57be7g30673fa6090df057@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1134416630.429.4.camel@blade>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 12 Dec 2005 20:43:50 +0100

Hi Arthur,

> After the weekend I finally get a reply to the email that I sent
> asking for pskeys.txt. 
> 
> "Unfortunately not. But I have pskeys.html instead. :) I hope that
> will do.
> Please do not pay attention to the default values mentioned in the
> file, some 
> of them may vary in out modules." 
> 
> I'm not sure whether I can attach files to this mailing list. So I
> send the pskeys.html file to your personal email (marcel@holtmann.org)
> seperately, hope that's fine. Once again, thanks a lot for your help. 

the pskeys.txt and pskeys.html contain the same information. I prefer a
text file, instead of a HTML file. Everybody who uses a decent OS knows
the reason for that ;)

However I think that you need to configure PSKEY_UART_CONFIG_H4 if you
wanna use H4 as transport. The problem actually are the values that
differ from the default. The one thing that the bccmd is missing is
support for SPI as transport otherwise it would read the non-default
values and we would see what they did with their modules. The PSTool can
actually do the same, but don't ask me how. I never did that before.

Maybe using BCSP as transport will work much better, because they didn't
fucked up its configuration.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
