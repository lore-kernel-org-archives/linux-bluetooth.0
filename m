Return-Path: <cyrus@holtmann.org>
Date: Mon, 9 Jan 2012 15:07:35 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Divya Yadav <divya.yadav@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] MAP: Add UpdateInbox Function
Message-ID: <20120109130735.GD19918@x220.ger.corp.intel.com>
References: <1325856716-17943-1-git-send-email-divya.yadav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1325856716-17943-1-git-send-email-divya.yadav@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Divya,

On Fri, Jan 06, 2012, Divya Yadav wrote:
> UpdateInbox function allows remote device to initiate an update of
> the MSE inbox, i.e. the MSE shall contact the network to retrieve
> new messages if available. If MSE does not support the network
> update it shall answer with a 'Not implemented' error response.
> ---
>  plugins/mas.c              |   37 ++++++++++++++++++++++++++++++++++++-
>  plugins/messages-dummy.c   |    7 +++++++
>  plugins/messages-tracker.c |    7 +++++++
>  plugins/messages.h         |   13 +++++++++++++
>  4 files changed, 63 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
