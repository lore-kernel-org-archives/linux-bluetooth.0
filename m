Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Feb 2011 18:15:55 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 2/3] Bluetooth: Add connection parameter update response
Message-ID: <20110215211555.GE7219@joana>
References: <1297459736-24514-1-git-send-email-claudio.takahasi@openbossa.org>
 <1297459736-24514-3-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297459736-24514-3-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

* Claudio Takahasi <claudio.takahasi@openbossa.org> [2011-02-11 19:28:55 -0200]:

> Implements L2CAP Connection Parameter Update Response defined in
> the Bluetooth Core Specification, Volume 3, Part A, section 4.21.
> Address the LE Connection Parameter Procedure initiated by the slave.
> 
> Connection Interval Minimum and Maximum have the same range: 6 to
> 3200. Time = N * 1.25ms. Minimum shall be less or equal to Maximum.
> The Slave Latency field shall have a value in the range of 0 to
> ((connSupervisionTimeout / connIntervalMax) - 1). Latency field shall
> be less than 500. connSupervisionTimeout = Timeout Multiplier * 10 ms.
> Multiplier field shall have a value in the range of 10 to 3200.
> 
> Signed-off-by: Claudio Takahasi <claudio.takahasi@openbossa.org>
> ---
>  include/net/bluetooth/l2cap.h |   15 ++++++++++
>  net/bluetooth/l2cap_core.c    |   60 ++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 74 insertions(+), 1 deletions(-)

Applied, after fix the conflict caused by the changes I did in the previous
patch. Thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
