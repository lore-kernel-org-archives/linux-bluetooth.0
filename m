Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <B2B9E083-A86D-426A-9E79-5F168A8FA017@holtmann.org>
References: <1412859828-6224-1-git-send-email-fons@spotify.com>
 <20141009141430.GA31807@t440s.P-661HNU-F1> <CAHF=Y4pJOC3gA1g-+o1e4HRJraFqpCGOAUuqNiS7b0CvAqEBJg@mail.gmail.com>
 <B2B9E083-A86D-426A-9E79-5F168A8FA017@holtmann.org>
From: Alfonso Acosta <fons@spotify.com>
Date: Fri, 10 Oct 2014 10:14:25 +0200
Message-ID: <CAHF=Y4p3Rn=Q3pdW3ML7=H00pBcGUSjr3SfAsm6v+Da8_LPcCQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Defer connection-parameter removal when
 unpairing without disconnecting
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,


> don't we also need to clear the flag when the new pairing succeed?

Yep, in fact that's the whole point of the flag .... which I missed.
Thanks for your patience :)

> If we destroy hci_conn anyway, there is pretty much no point in test_and_clear_bit and we could just use test_bit here.

Fair point, I will change them to test_bit.




-- 
Alfonso Acosta

Embedded Systems Engineer at Spotify
Birger Jarlsgatan 61, Stockholm, Sweden
http://www.spotify.com
