Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 Mar 2013 09:25:29 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Brendan West <extremeskateboarding@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Problem Running Bluez Tests
Message-ID: <20130326072529.GA30560@x220>
References: <CAB8sVA-XJeACK9YHEB0V3vLHbskPaVe6A+C9_oM6t2jP-UV+pQ@mail.gmail.com>
 <20130325162309.GA25769@x220.P-661HNU-F1>
 <CAB8sVA-r2EnKTKWT+tp-eQo0r-nFS58cwpF_gNQ9Hi_v7xtZsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAB8sVA-r2EnKTKWT+tp-eQo0r-nFS58cwpF_gNQ9Hi_v7xtZsA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brendan,

On Mon, Mar 25, 2013, Brendan West wrote:
> That sounds like it could be the problem.  However, shouldn't the old
> bluetoothd stop and the new one start when I reboot the Raspberry Pi?
> Or do I actually have to do it manually?  If the latter, can you
> explain how to do so (I am not sure how two different versions can be
> installed at the same time..I was under the impression that a normal
> install of the new would overwrite the old).

BlueZ 5.x installs bluetoothd by default into /usr/libexec/bluetooth/
whereas 4.x installs it to /usr/sbin/, so it wouldn't get overwritten.

> As for the D-Bus policy, I'm afraid that I am still not sure how to do
> that one either..  I have updated D-Bus using apt-get, but you seem to
> be referring to something else..  Would you mind explaining further?

D-Bus policy files are provided by each service that needs them. You
won't get the new BlueZ policy with some centralized D-Bus package. I
tried to tell you that you'll find the policy file in the BlueZ source
tree and you just need to copy it to the right place (also explained in
my email).

Johan
