Return-Path: <cyrus@holtmann.org>
Message-ID: <4798987E.6060600@naustech.com>
Date: Thu, 24 Jan 2008 14:54:06 +0100
From: "Ing. Gabriele Oberhammer" <gabriele@naustech.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <860396.82093.qm@web8411.mail.in.yahoo.com>
In-Reply-To: <860396.82093.qm@web8411.mail.in.yahoo.com>
Subject: Re: [Bluez-users] Headset half working using Bluez's ALSA plugin
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

tnx for your response, but I've a standard Ubuntu kernel and alsa i 
correcty configured.
Running dpkg -S libasound_module_pcm_bluetooth.la I found that this 
module is shipped with the package bluez-utils.
If I install the package bluez-utils form standard repositories almost 
everything of bluetooth works flawlessly. The problem is that capture 
from my headset does not work (i.e. only playback works).
Several posts confirm that this is a common problem which the latest cvs 
is supposed to solve.
I've correctly compiled and installed latest blues-utils form cvs, but I 
guess the library libasound_module_pcm_bluetooth.la is not correctly 
build/installed  :-(

I guess I must wait until the cvs becomes stable.

Tnx, bye

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
