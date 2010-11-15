Return-Path: <cyrus@holtmann.org>
Date: Mon, 15 Nov 2010 14:05:33 +0000
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Bruna Moreira <bruna.moreira@openbossa.org>
Subject: Re: [PATCH v3 1/4] Initial advertising data parsing implementation
Message-ID: <20101115140533.GA11936@jh-x301>
References: <1289518769-3009-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289518769-3009-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Nov 11, 2010, Vinicius Costa Gomes wrote:
> Implement adapter_update_adv() function to parse advertising data
> received by btd_event_adv() function. Add some fields for advertising
> data in remote_device_info struct.
> ---
>  plugins/hciops.c |    9 +++------
>  src/adapter.c    |   26 ++++++++++++++++++++++++++
>  src/adapter.h    |    6 ++++++
>  src/event.c      |   13 +++++++++++++
>  src/event.h      |    1 +
>  5 files changed, 49 insertions(+), 6 deletions(-)

Pushed upstream. Thanks.

Johan
