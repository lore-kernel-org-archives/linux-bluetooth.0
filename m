Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTi=L1xG3gVi9bmuW_YSWcOmu1HiRoQ@mail.gmail.com>
References: <BANLkTi=L1xG3gVi9bmuW_YSWcOmu1HiRoQ@mail.gmail.com>
Date: Thu, 26 May 2011 18:44:22 +0300
Message-ID: <BANLkTin3vWrRigXOHQbJKr3rbN1xoirdYw@mail.gmail.com>
Subject: Re: [PATCH] Init telephony before adding HFP SDP records
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Daniel_=D6rstadius?= <daniel.orstadius@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Thu, May 26, 2011 at 4:58 PM, Daniel Örstadius
<daniel.orstadius@gmail.com> wrote:
> Please review.

For telephony-maemo6 it should be enough to just call
headset_server_init after state_changed/telephony_init.

Now this won't work with telephony-ofono since it waits some network
to be available before it signals it is ready, but I guess we can move
to its call of telepfony_ready_ind to telephony_init since the
features bits does not seems to depend in network availability.

Regards,

-- 
Luiz Augusto von Dentz
Computer Engineer
