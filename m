Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: keybuk@google.com
In-Reply-To: <1363839008-8405-1-git-send-email-deymo@chromium.org>
References: <1363839008-8405-1-git-send-email-deymo@chromium.org>
Date: Thu, 21 Mar 2013 16:10:10 -0700
Message-ID: <CAHZ1yCmXJLH+14wj2_kMLaJM4Pi8ttQCFzkiVAy-HKR1us+Amg@mail.gmail.com>
Subject: Re: [PATCH 0/6] The Autopair strikes back
From: Scott James Remnant <keybuk@chromium.org>
To: Alex Deymo <deymo@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Mar 20, 2013 at 9:10 PM, Alex Deymo <deymo@chromium.org> wrote:

> The implemented logic is:
> For each new org.bluez.Device1.Pair call that ends in a pin request (not SSP)
> we *iterate* the list of pincode callbacks from plugins trying every callback
> until it returns 0 (no pincode).
>

Does this mean that the user/agent will have to issue repeated Pair
attempts/method calls to successfully pair a device? That seems like a
poor user experience to me, and is different to the patches previously
submitted which would retry inside the Bluetooth daemon.

There's also the risk that the first failed pairing attempt will, if
you drop the connection to the device, cause the device to leave page
scan mode entirely requiring user interaction there as well
(re-pushing the Connect/Pair button, for example).

Scott
--
Scott James Remnant | Chrome OS Systems | keybuk@google.com | Google
