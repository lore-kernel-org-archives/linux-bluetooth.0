Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110711125254.GA16751@dell.ger.corp.intel.com>
References: <1310386806-19305-1-git-send-email-dmitriy.paliy@nokia.com>
	<1310386806-19305-2-git-send-email-dmitriy.paliy@nokia.com>
	<20110711125254.GA16751@dell.ger.corp.intel.com>
Date: Mon, 11 Jul 2011 20:39:34 +0300
Message-ID: <CAHMBquXkBSqXudGaMBZZF=cGUci+6yT8AuU+NO-c_vp5=8nrkw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3] Fix unpair device when disconnected for No Bonding
From: Dmitriy Paliy <dmitriy.paliy@gmail.com>
To: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Mon, Jul 11, 2011 at 3:52 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Applied, and I also pushed a cleanup patch on top of it because
> device_remove_bonding was essentially useless. One thing that I'm
> thinking of is maybe it'd be better to get rid of the paired and bonded
> booleans have a single enum for them since they are dependent on each
> other and one combination of boolean values (!paired && bonded) is not
> possible. Maybe something like the following inside struct btd_device:
>
>        enum {
>                DEVICE_PAIRING_STATUS_NONE,
>                DEVICE_PAIRING_STATUS_PAIRED,
>                DEVICE_PAIRING_STATUS_BONDED,
>        } pairing_status;
>
> Thoughts?

Sounds wise, I will check solution for hci_ops and mgmt_ops.

BR,
Dmitriy
