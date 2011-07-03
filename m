Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTinhYCGbzLXTeMJo7uf_0+-dA_zSig@mail.gmail.com>
References: <BANLkTikVuJ4RdV4Ng1ROh9Oc80K6p8ZQBw@mail.gmail.com>
	<BANLkTinhYCGbzLXTeMJo7uf_0+-dA_zSig@mail.gmail.com>
Date: Sat, 2 Jul 2011 19:35:33 -0600
Message-ID: <CAKLsOONx6QgTPLRX=tm7KhYpfkeEq+A4JgXocmsLHONmTBZo8Q@mail.gmail.com>
Subject: Re: sco routing
From: Brad Midgley <bmidgley@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey

test-audio connect xx seems to work, I can hear the audio channel
firing up and see it in the hcitool con output. But it changes from
esco to sco then sco closes and only the acl is left. I want to test
sco routing on my board, so I'd like it to keep a sco connection up.
Is that possible? Would problems in the pcm setup on the board cause
the bt chip to close sco?

# ./test-audio connect 00:0D:3C:37:46:22 ; hcitool con
Connections:
	< eSCO 00:0D:3C:37:46:22 handle 0 state 5 lm SLAVE
	< ACL 00:0D:3C:37:46:22 handle 42 state 1 lm SLAVE AUTH ENCRYPT
root@linaro:~# hcitool con
Connections:
	< SCO 00:0D:3C:37:46:22 handle 46 state 1 lm SLAVE
	< ACL 00:0D:3C:37:46:22 handle 42 state 1 lm SLAVE AUTH ENCRYPT
root@linaro:~# hcitool con
Connections:
	< ACL 00:0D:3C:37:46:22 handle 42 state 1 lm SLAVE AUTH ENCRYPT

hcidump is at https://gist.github.com/1061877

thanks guys
Brad
