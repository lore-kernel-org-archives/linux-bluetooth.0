Return-Path: <cyrus@holtmann.org>
Message-ID: <2d5a2c100803210641h220d4de2md9392f7752796169@mail.gmail.com>
Date: Fri, 21 Mar 2008 10:41:32 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1ffb4b070803202045w31d2ca9lcc66d0a51aef8c@mail.gmail.com>
MIME-Version: 1.0
References: <1ffb4b070803202045w31d2ca9lcc66d0a51aef8c@mail.gmail.com>
Subject: Re: [Bluez-devel] Is there any bluez audio source(a2src)
	implementation
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

I've been working in the audio sink implementation (...Audio.Source interfa=
ce),
but because of the changes we are now doing for bluez 4.0 I left that
unfinished.

The code is available in my branch audio-source:
http://git.infradead.org/users/vudentz/bluez-utils.git?a=3Dlog;h=3Drefs/hea=
ds/audio-source

I was already able to configure streams between 2 linux boxes, but
there is no plugin to
handle the streams yet.

This task is also available in gsoc page, so any student interested may app=
ly:
http://wiki.bluez.org/wiki/GSoC2008

-- =

Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
