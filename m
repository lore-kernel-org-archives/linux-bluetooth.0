Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Jan 2011 12:19:03 +0530
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: ville.tervo@nokia.com
Subject: Re: [PATCH 1/5] Revert "Bluetooth: Update sec_level/auth_type for
 already existing connections"
Message-ID: <20110119064903.GA25924@jh-x301>
References: <1295419012-25717-1-git-send-email-johan.hedberg@gmail.com>
 <1295419012-25717-2-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1295419012-25717-2-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Wed, Jan 19, 2011, johan.hedberg@gmail.com wrote:
> - The conn->sec_level should be updated without performing

Stupid typo: s/should/shouldn't/

Do you want me to resend or will you fix it manually yourself (e.g. git
commit --amend)?

Johan
