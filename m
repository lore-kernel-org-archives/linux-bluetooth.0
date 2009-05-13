Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] add support for HFP plugin for oFono
From: Marcel Holtmann <marcel@holtmann.org>
To: Forrest Zhao <forrest.zhao@intel.com>
Cc: linux-bluetooth@vger.kernel.org, forrest.zhao@gmail.com
In-Reply-To: <1242181798-24059-1-git-send-email-forrest.zhao@intel.com>
References: <1242181798-24059-1-git-send-email-forrest.zhao@intel.com>
Content-Type: text/plain
Date: Tue, 12 May 2009 19:43:54 -0700
Message-Id: <1242182634.27899.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Forrest,

> The attached the patch implement the HFP plugin for oFono(ofono.org).
> Your comments are welcome.

please call the file telephony-ofono.c since the oFono writing if you
use it withing written text references. Filenames and variables should
write if ofono.

Once merged you are responsible for making sure the compilation always
works. I am only testing the dummy code during release engineering.

Regards

Marcel


