Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 5 May 2010 14:57:45 -0700
Message-ID: <h2q995d6c6b1005051457y48748e8am16cb509bd7b6d969@mail.gmail.com>
Subject: choosing SCO parameters at run time
From: takeiteasy <pdatta17@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,



I have a question related to SCO packet path configuration for
Bluetooth HSP/HFP profiles. As I understand,
we need to use SCO routing option in etc/bluetooth/audio.conf to
select the voice path to be over HCI or PCM.
It seems the option is configured at the init time.Can I select PCM or
HCI routing at runtime?

One of the ways we are looking at is to have the application layer
make calls to bluez stack via d-bus say in headset.c
to set the relevant variable.

regards
