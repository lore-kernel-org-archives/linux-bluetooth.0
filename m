Return-Path: <cyrus@holtmann.org>
Date: Wed, 22 Dec 2010 13:58:29 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 04/18] Add a way to store the remote device type
Message-ID: <20101222115827.GD27483@jh-x301>
References: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
 <1292966800-6264-5-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1292966800-6264-5-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Tue, Dec 21, 2010, Vinicius Costa Gomes wrote:
> Because we need to know the device type (LE, Basic Rate or Dual Mode)
> to be able to fully restore the device from storage, we have to store
> and load this information to permanent storage.
> 
> Note: due to "device_type_t" usage in storage.h, some header includes
> needed to be reordered in files which include storage.h.
> ---
>  input/device.c   |    4 ++--
>  plugins/hciops.c |    2 +-
>  serial/port.c    |    2 ++
>  src/storage.c    |   40 ++++++++++++++++++++++++++++++++++++++++
>  src/storage.h    |    3 +++
>  5 files changed, 48 insertions(+), 3 deletions(-)

Pushed upstream. Thanks.

Johan
