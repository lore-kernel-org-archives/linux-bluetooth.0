Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 23 Apr 2007 12:18:38 +0200
From: Stefan Seyfried <seife@suse.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20070423101838.GF8944@suse.de>
References: <c38065090704221038ia8dacc9i84818502e76ecb67@mail.gmail.com>
	<200704222139.42500.cijoml@volny.cz>
	<c38065090704221456s3194f809vaf65418873f6f9ff@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <c38065090704221456s3194f809vaf65418873f6f9ff@mail.gmail.com>
Subject: Re: [Bluez-users] Can't connect to Freedom Input Mini Duo keyboard
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Sun, Apr 22, 2007 at 04:56:35PM -0500, Philip S. Trasatti Jr. wrote:
> Thanks for the response. Still doesn't work.
> 
> hidd is running with the --server and --master options
> 
> When I run hidd the second time I get...
> 
> # hidd --connect 00:0B:0D:6F:7F:88
> Can't create HID control channel: Connection reset by peer

did you press the "connect" button on the keyboard? I always connect
keyboards / mice by (with hidd --server already running):

- hidd --search (as root)
- then press the connect button on the keyboard / mouse and pressing
  some keys / moving the mouse, to see once it is connected.

and this has worked fine for me all the time.
-- 
Stefan Seyfried

"Any ideas, John?"
"Well, surrounding them's out." 

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
