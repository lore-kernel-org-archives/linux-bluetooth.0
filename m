Return-Path: <cyrus@holtmann.org>
Date: Wed, 17 Dec 2014 01:23:51 -0800
From: Tristan Lelong <tristan@lelong.xyz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] hci_bcsp: Add LE protocol on kernel side
Message-ID: <20141217092351.GA9734@lenderer>
References: <1418368478-13956-1-git-send-email-tristan@lelong.xyz>
 <1418368478-13956-2-git-send-email-tristan@lelong.xyz>
 <0E818206-73C3-476C-BB9D-7CC686ED7FEC@holtmann.org>
 <20141213062623.GA3058@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141213062623.GA3058@localhost.localdomain>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I took care of all the comments and started to test the patch.
I probably need to modify some code on the userland side for better testing.

I have a bug to fix already, probably caused by the cleanup of the patch.

I'll do this and resubmit the patch once fully tested and working.

Best regards
