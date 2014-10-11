Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2F926C4D-DBA0-4B6C-A368-FD8E95509A5A@holtmann.org>
References: <1413037644-15858-1-git-send-email-fons@spotify.com> <2F926C4D-DBA0-4B6C-A368-FD8E95509A5A@holtmann.org>
From: Alfonso Acosta <fons@spotify.com>
Date: Sat, 11 Oct 2014 23:44:43 +0200
Message-ID: <CAHF=Y4qgqd+cdSNp-wib94ztC+ZNc5zfsWRBDa9QuPEy3R5hAA@mail.gmail.com>
Subject: Re: [PATCH v5] Bluetooth: Defer connection-parameter removal when unpairing
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> I would have put an extra comment here as well to remind us that conn is for indicating to terminate the connection or not. See my review of v4 of your patch.
>
>>       if (!conn) {
>>               err = cmd_complete(sk, hdev->id, MGMT_OP_UNPAIR_DEVICE, 0,
>>                                  &rp, sizeof(rp));

Ops, I missed that one. v6 includes the comment.

Thanks,

Fons

-- 
Alfonso Acosta

Embedded Systems Engineer at Spotify
Birger Jarlsgatan 61, Stockholm, Sweden
http://www.spotify.com
