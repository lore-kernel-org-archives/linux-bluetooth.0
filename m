Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Dec 2011 16:09:01 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Hemant Gupta <hemantgupta.ste@gmail.com>
Cc: Hemant Gupta <hemant.gupta@stericsson.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2] mgmt: Add support for Passkey handling
Message-ID: <20111215140901.GB3164@x220>
References: <1323950056-28708-1-git-send-email-hemant.gupta@stericsson.com>
 <20111215120851.GA10113@x220>
 <CACj007=R3bmR2e=xgAdSXPXb12OdkAPXh_0qGba+mM46KBjjyQ@mail.gmail.com>
 <20111215135616.GA3164@x220>
 <CACj007mVHuigfhHxg9FsA5PEVYtft0veGqh82YSPJENF7ExAjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACj007mVHuigfhHxg9FsA5PEVYtft0veGqh82YSPJENF7ExAjA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Dec 15, 2011, Hemant Gupta wrote:
> In my code, I am using htobl(passkey), while passkey is sent to kernel.
> So you mean I need to change it to btohl ?

No, you use htobl when encoding (writing to) a mgmt message and btohl
when decoding (reading from) one.

Johan
