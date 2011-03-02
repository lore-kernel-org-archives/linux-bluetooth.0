Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4D6EAA7D.70508@interlinx.bc.ca>
References: <4D6EAA7D.70508@interlinx.bc.ca>
Date: Wed, 2 Mar 2011 13:59:13 -0700
Message-ID: <AANLkTi=g41vRaS_1CfEmikHGUxh_DSrHb4AaQRAxR=he@mail.gmail.com>
Subject: Re: cannot use multiple devices reliably
From: Brad Midgley <bmidgley@gmail.com>
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Brian,

> Additionally, as I move the mouse, there is crackling in the headset.

In the past, the workaround was to make sure the computer's adapter
was master in the piconet. If it's a slave, there's downtime as it
switches from one piconet to the other. Connection order and the
devices you use can affect which device assumes master.

This used to be done in a config file. Maybe there's a d-bus hook or
something like that now. specifically, this was "lm master" in the old
hcid.conf

-- 
Brad Midgley
