Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Jan 2012 15:16:07 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Divya Yadav <divya.yadav@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] MAP: Add application parameter parsing support
Message-ID: <20120112131607.GA13175@x220.ger.corp.intel.com>
References: <1326373161-4618-1-git-send-email-divya.yadav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1326373161-4618-1-git-send-email-divya.yadav@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jan 12, 2012, Divya Yadav wrote:
> Add application parameter parsing and check for
> mandatory parameters.
> ---
>  plugins/mas.c      |  187 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>  plugins/messages.h |   19 +++++
>  2 files changed, 199 insertions(+), 7 deletions(-)

Are you aware of src/map_ap.h that we have in the obexd tree?

Johan
