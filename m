Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <35741970-1ED7-4A2B-8625-4F16186FA764@holtmann.org>
References: <1411746855-9936-1-git-send-email-fons@spotify.com>
 <24D2CD11-D43B-4F53-8A7C-175934A54C87@holtmann.org> <CAHF=Y4owMj-RBquSk2GWVjGSL4H1SU0qC6pVEN6DJvdmyqw9zA@mail.gmail.com>
 <BCEE5DFC-08DA-43A7-AED8-BEFD837B07ED@holtmann.org> <CAHF=Y4p-st7N4+kUezYWjy7L58zcH-1t0AO0ME6axZ76ZK+oKQ@mail.gmail.com>
 <1D7AEE8B-51DB-4A6D-8EBA-3EC81760224E@holtmann.org> <CAHF=Y4pkXTvcN6YQTH6DPboeav7BCa8T0HUSfOHfag+W9GJ8fQ@mail.gmail.com>
 <CAHF=Y4r0Dx1b8vwWAwTWSNq+JD_1_622px4UG4FD1vsfS+BWiw@mail.gmail.com> <35741970-1ED7-4A2B-8625-4F16186FA764@holtmann.org>
From: Alfonso Acosta <fons@spotify.com>
Date: Thu, 9 Oct 2014 03:01:32 +0200
Message-ID: <CAHF=Y4rhOMZ684riRJNrqOjnCXW_CuNdjCfTRtAVRg=dWUfxQA@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: Add HCI_AUTO_CONN_DIRECT_REPORT_IND
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,


> what sounds most simple to me is that we allow for a way to suspend and later resume the trigger for doing service discovery. Attaching the attribute channel is fine, but then essentially tell it to stay put.
>
> This all becomes tricky and we might need to have some redesign and cleanups to do to make this work cleanly. We also long term want to switch to the newly designed gatt-client.c that we are working on. So something to keep in mind.
>
> However one thing has to present and that is our GATT server. So even if we stall everything else and even if we drop the keys and unpair, the GATT server needs to be operational. So we need to attach the ATT protocol to the ATT socket that we are getting from the kernel on every single connection.

Thanks. Using your suggestion I am suspending the trigger for doing
service discovery until rebonding is completed. As expected, without
the connection re-establishment, rebonding is now considerably faster.

I, however, have to keep the ATT socket around until resuming the
service discovery, which is a bit dirty. But I guess I can live with
that until the new gatt-client is in.

Thanks again,

Fons

-- 
Alfonso Acosta

Embedded Systems Engineer at Spotify
Birger Jarlsgatan 61, Stockholm, Sweden
http://www.spotify.com
