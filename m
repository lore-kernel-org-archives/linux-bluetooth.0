Return-Path: <cyrus@holtmann.org>
Date: Fri, 7 Oct 2011 23:31:05 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v5 13/15] Bluetooth: LE scan infra-structure
Message-ID: <20111007203105.GC23669@fusion.localdomain>
References: <1317856847-28167-1-git-send-email-andre.guedes@openbossa.org>
 <1317856847-28167-14-git-send-email-andre.guedes@openbossa.org>
 <20111006190618.GJ5652@joana>
 <781D602C-370E-4F06-9D4D-DC69F27294E7@openbossa.org>
 <20111007201233.GB4108@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111007201233.GB4108@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Fri, Oct 07, 2011, Gustavo Padovan wrote:
> hdev->flags is exported to userspace, it is not internal. We need to create
> other place in struct hci_dev to keep this info. See some of Marcel's reply on
> this.

I think the best idea proposed so far is to have a hdev->legacy_flags
with a bare minimum set of possible values (HCI_UP, etc). This variable
is then exported to user space while a new hdev->flags can be created
which remains private within the kernel.

Johan
