Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <872F1D49-E810-4D33-9B05-ED3DDBA64336@holtmann.org>
References: <1412859828-6224-1-git-send-email-fons@spotify.com>
 <CAHF=Y4oTZjk6k0YeBA6xEpksZRWU1TTtkZfB+YESWmmRxNs0GA@mail.gmail.com> <872F1D49-E810-4D33-9B05-ED3DDBA64336@holtmann.org>
From: Alfonso Acosta <fons@spotify.com>
Date: Sat, 11 Oct 2014 02:14:23 +0200
Message-ID: <CAHF=Y4q2ii0jGLXuBVu1ZOOqmQQ+m+zCne-Jizzjr6UkfcgWXA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Defer connection-parameter removal when
 unpairing without disconnecting
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> I am not in favor of making Pair Device just do re-pairing. I think that =
is a dangerous behavior since want bondings in the kernel only in two ways.=
 Either they are loaded via Load Long Term Keys or via Pair Device. Doing s=
omething magic is something that I consider dangerous and can lead into som=
e flaws. If we come with a clear error than we at least know that something=
 went wrong.
>
> Repairing command is possible, but I am not 100% convinced that it is a g=
ood idea. The normal workflow is that you pair and unpair a device. If you =
get stuck in a weird state, you unpair first which ensures that everything =
is cleaned out and then pair again. For the connection parameters we can ju=
st be smarter.

Fair enough. Does this mean that the current patch is still of
interest? I hope so :)

> I bet there is still a lot of improvement for our connection parameter ha=
ndling. For example we could just keep all connection parameters around in =
cache and just expire them after 1 day or so. That would improve general ha=
ndling with devices with do not pair in the first. So I would focus on bein=
g smart when dropping connection parameters and not trying to bind it too m=
uch to mgmt API visible states.

I actually have a patch lying around which keeps track of
conn_parameters within bluetoothd. I think that it would be a good
start (I would like to complete the submissions I sent this week
getting to it though).


--=20
Alfonso Acosta

Embedded Systems Engineer at Spotify
Birger Jarlsgatan 61, Stockholm, Sweden
http://www.spotify.com
