Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20040929112930.56699.qmail@web53207.mail.yahoo.com>
From: Massimiliano Cuccia <massimiliano_cuccia@yahoo.com>
Subject: Re: [Bluez-users] obexFTP ... does it works?
To: Bluez-users@lists.sourceforge.net
In-Reply-To: <41591760.90208@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 29 Sep 2004 04:29:30 -0700 (PDT)

--- GUILLON Gabriel <gabriel.guillon@c-s.fr> wrote:
> I just tried obexftp on friday. I use channel 4.

I want to send the file named pippo.txt
this is what i'm doing
---- first i search for my phone

maxc@linux:~/prj/4/utils> hcitool scan
Scanning ...
        00:60:57:FB:3F:CE       MaxCube6600

---- next try to send the file
maxc@linux:~/prj/4/utils> obexftp -b 00:60:57:FB:3F:CE
-B 10 -p pippo.txt
No custom transport
Connecting...bt: 1
failed: S45 UUID
done
Sending pippo.txt...\failed: pippo.txt
Disconnecting...done
maxc@linux:~/prj/4/utils> 

If I try channel 4 it doesn't write the send line like
above. It writes connecting/failed pair three times.
(sorry I don't have the transcription of my shell)

are these the same steps you do to achieve transfer of
file?
thanks




	
		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
http://promotions.yahoo.com/new_mail 


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
