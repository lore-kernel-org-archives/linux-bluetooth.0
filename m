Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <447CAAE4.3040202@xmission.com>
Date: Tue, 30 May 2006 14:28:20 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <7A6DA545D7FDCC4B93DB651FDBC1EDDE46C2E7@eumonex01.palmsource.com>	<4464C195.1020403@xmission.com>	<446B54AF.5040302@palmsource.com>
	<447A9C7B.2040301@xmission.com> <447C1C70.1030309@palmsource.com>
In-Reply-To: <447C1C70.1030309@palmsource.com>
Subject: Re: [Bluez-devel] A2DP and Alsa Plugin
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Fr=E9d=E9ric

>>Ideally it's a system function, but I'm not seeing a way to pull that off.
>> =

> gstreamer makes it easy to write applications, but application writer =

> can choose whatever sink he wants. We cant rely on application being =

> a2dp aware.

I just read this more carefully... so the system would do things like
discover headsets, pair, update .asoundrc (or equivalent). The app
should only have to search for a plugin and let the user choose it.

Brad


_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
