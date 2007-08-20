Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46C9D2E0.5050404@free.fr>
Date: Mon, 20 Aug 2007 19:44:00 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <46C875BA.90204@free.fr>
	<2d5a2c100708191902k599014cbo1e08c9c7a3febd45@mail.gmail.com>
In-Reply-To: <2d5a2c100708191902k599014cbo1e08c9c7a3febd45@mail.gmail.com>
Subject: Re: [Bluez-devel] [PATCH] pcm_bluetooth : fix a2dp streaming
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

Hi Luiz,

Please find a few remarks below:

> I got almost the same idea implemented in my git
> (git://git.infradead.org/users/vudentz/bluez-utils.git). 

Should make sense then :-)

There is
> alot of simplification you already did, but I consider the
> bitrate as a2dp spec says.

Oh... about this bitrate stuff i must say i'm quite confused : where did 
you find anything in the spec ? (I have A2DP 1.0 but didn't find 
anything :-( )

> I also implement a circular
> buffer for encoded sbc frames to be consumed by a
> thread.

That was another option, however it was not that clear what the benefits 
from it would be, so i took the easiest to implement alternative, and 
just sent data as they arrived ;-)

Cheers,

Fabien

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
