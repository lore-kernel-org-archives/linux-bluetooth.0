Return-Path: <cyrus@holtmann.org>
Date: Fri, 7 Mar 2014 09:04:18 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: Background scanning and white list usage
Message-ID: <20140307070418.GB10537@localhost.P-661HNU-F1>
References: <BFAEE1C5-E74F-40F0-A1A4-8F4907FBDCF4@holtmann.org>
 <20140228064422.GA28466@localhost.P-661HNU-F1>
 <B2E73B9C-3787-4B4B-802B-0C76302BF8F9@holtmann.org>
 <5318E560.6050200@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5318E560.6050200@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Thu, Mar 06, 2014, Andre Guedes wrote:
> The problem with enabling filter duplicates in background scan
> happens in the following scenario:
>   * Background scan is running.
>   * A device disconnects and starts advertising.
>   * Before host gets the disconnect event, the advertising is reported
>     to host. Since there is no pending LE connection at that time,
>     nothing happens.
>   * Host gets the disconnection event and adds a pending connection.
>   * No advertising is reported (since controller is filtering) and the
>     connection is never established.
> 
> To address this scenario, all we have to do is: always restart
> background scan when a new LE pending connection is added. This way,
> we unsure that we don't miss the advertising report.
> 
> If you guys agree with this approach I can write the patches.

Sounds fairly reasonable to me, if it actually end up working ok.

Johan
