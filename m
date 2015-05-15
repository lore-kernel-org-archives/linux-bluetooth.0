Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 14 May 2015 17:49:21 -0700
Message-ID: <CAHgsZ+i5rBNk8dPOzEHhJ8UVVezxNYZBsbTtrCSJqBmaZ1VcNA@mail.gmail.com>
Subject: [A2DP] - Try to write audio data to L2CAP socket and receive EAGAIN
 as return after scanning starts.
From: Miao-chen Chou <mcchou@google.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When playing with JBL charge 2 speaker, I found that the music
stutters badly whenever I start scanning, and it goes back to normal
after the scanning finishes. I am wondering if this is a bug in Bluez,
so I tried another speaker, Beats Pill, but it turns out that Pill
plays smoothly even if I start scanning.

Speakers:
- JBL charge 2 (A2DP/HSP/HFP)
- Beats Pill (A2DP/HSP)
Since I only use the speakers for audio output, A2DP profile was used.

Somehow L2CAP socket buffer has no space for the outgoing audio data
during scanning, so I keep getting EAGAIN error. My guess is that the
previous frames have been accumulated but never been consumed, but who
is blocking ACL for sending audio data?

Does anyone see this issue before?

Thanks,
-Miao
