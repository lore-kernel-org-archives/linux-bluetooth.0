Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: ipc-common.h missing in bluez 5.16
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <50C3158CF44D924791C15F1437EF2EC65D29E4@HASMSX104.ger.corp.intel.com>
Date: Fri, 14 Mar 2014 10:39:22 -0700
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <A2E11030-93A8-4EE8-8665-A5F4455A8EC7@holtmann.org>
References: <50C3158CF44D924791C15F1437EF2EC65D29E4@HASMSX104.ger.corp.intel.com>
To: "Poulain, Loic" <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> I Downloaded bluez-5.16.tar.xz from bluez.org, but there is a compile issue for android target.
> ipc-common.h is missing (in /android). Adding this file from master make it works.

that is totally a mistake on our side. I fixed this upstream now and made sure next time we build a tarball it is included.

For now, just copy it in manually from our GIT repository. Sorry for the inconvenience.

Regards

Marcel

