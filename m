Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 5 Jul 2012 14:00:54 +0800
Message-ID: <CADX0rsZBM+2Sz564FrkVxe318dCFue_pea_OLpxvrk5bd9cHWQ@mail.gmail.com>
Subject: BT LMP
From: victor yeo <victoryeo1974@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Anyone know which part of linux kernel processes the LMP au_rand and
LMP not_accepted event?

I want to modify the Bluetooth kernel code so that when it receives
LMP not_accepted event, it will do re-pairing.

Thanks,
Victor
