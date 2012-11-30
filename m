Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1354318625-15066-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1354318625-15066-1-git-send-email-vinicius.gomes@openbossa.org>
Date: Fri, 30 Nov 2012 20:45:09 -0300
Message-ID: <CAE6HaMk1=kb2LPmqM8EE3YH6HruD7sJTgksEUwoMywMPvaoxzg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] input: Fix emitting a signal for a non-existant interface
From: Vinicius Gomes <vinicius.gomes@openbossa.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Nov 30, 2012 at 8:37 PM, Vinicius Costa Gomes
<vinicius.gomes@openbossa.org> wrote:
> When the 'org.bluez.Input' interface was removed, this should have been
> removed as well, now it is causing a segmentation fault.
> ---

Please ignore this patch. I didn't notice that the signal is emitted
in another place too. Updated version coming soon.


Cheers,
--
Vinicius
