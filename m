Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <b8950797050111232241c3de8b@mail.gmail.com>
From: Weston Weems <wweems@gmail.com>
To: Bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-users] replicate hcitool scan using bluez libs
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
Date: Tue, 11 Jan 2005 23:22:59 -0800

I am a little new to the bluez libs etc, and am trying to essentiall
call functions in the bluez libs to simulate "scan" behaviour of
hcitool.

At first I thought it was inquiry in hci.h but after running the
tools, seems like they yeild different results. Also, device_id is id
of the bluetooth radio in the system?

Anyway I'd appreciate any guidance on the issue... 

many thanks in advance
Weston Weems


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
