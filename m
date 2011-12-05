Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4EDC77AA.3020801@globaledgesoft.com>
References: <4EDC77AA.3020801@globaledgesoft.com>
Date: Mon, 5 Dec 2011 10:43:36 +0200
Message-ID: <CABBYNZLrJsqwbN6hs_DU0aeL5T9DFuLMO3=ZEND+iE=DdhUA6A@mail.gmail.com>
Subject: Re: mpris-player
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Deepthi <deepthi.pv@globaledgesoft.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Dec 5, 2011 at 9:50 AM, Deepthi <deepthi.pv@globaledgesoft.com> wrote:
>
>
> Hello,
>
>
>    While executing the mpris-player , I 'm getting error saying :No
> such Object path  /org/mpris/MediaPlayer2. Please help.

This means your player is probably no following the mpris spec as it
should, http://www.mpris.org/2.1/spec/:

The media player must expose the /org/mpris/MediaPlayer2 object path,
which must implement the following interfaces:
org.mpris.MediaPlayer2
org.mpris.MediaPlayer2.Player

Version 1.0 of mpris is currently not supported by mpris-player.

-- 
Luiz Augusto von Dentz
