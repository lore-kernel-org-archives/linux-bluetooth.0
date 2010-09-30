Return-Path: <cyrus@holtmann.org>
Date: Thu, 30 Sep 2010 10:31:03 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Ville Tervo <ville.tervo@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Add master/slave parsing for le_conn_complete event
Message-ID: <20100930073103.GA6687@jh-x301>
References: <1285768581-19654-1-git-send-email-ville.tervo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1285768581-19654-1-git-send-email-ville.tervo@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ville,

On Wed, Sep 29, 2010, Ville Tervo wrote:
> ---
>  parser/hci.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

Thanks for the patch. I've pushed it to the upstream hcidump tree with
the following whitespace fix:

> +		evt->status, btohs(evt->handle), evt->role?"slave":"master");

It should be 'evt->role ? "slave" : "master"' i.e. you've got some
missing spaces there.

Johan
