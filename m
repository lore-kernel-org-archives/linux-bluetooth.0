Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] add support for HFP plugin for oFono(ofono.org)
From: Marcel Holtmann <marcel@holtmann.org>
To: Forrest Zhao <forrest.zhao@intel.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1242199258-10136-1-git-send-email-forrest.zhao@intel.com>
References: <1242199258-10136-1-git-send-email-forrest.zhao@intel.com>
Content-Type: text/plain
Date: Wed, 13 May 2009 00:40:36 -0700
Message-Id: <1242200436.27899.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Forrest,

> ---
>  audio/Makefile.am       |    3 +-
>  audio/telephony-ofono.c | 1116 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 1118 insertions(+), 1 deletions(-)
>  create mode 100644 audio/telephony-ofono.c

patch has been applied, but as mentioned on IRC, you need to use

	./bootstrap-configure --with-telephony=ofono

to ensure that no GCC warnings are present anymore :)

Regards

Marcel


