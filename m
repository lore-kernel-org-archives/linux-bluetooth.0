Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/3] Bluetooth: Create l2cap_send_disconn_req()
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1248254976-12090-3-git-send-email-gustavo@las.ic.unicamp.br>
References: <1248254976-12090-1-git-send-email-gustavo@las.ic.unicamp.br>
	 <1248254976-12090-2-git-send-email-gustavo@las.ic.unicamp.br>
	 <1248254976-12090-3-git-send-email-gustavo@las.ic.unicamp.br>
Content-Type: text/plain
Date: Wed, 22 Jul 2009 11:50:35 +0200
Message-Id: <1248256235.28545.123.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> The code for sending a disconnect request was repetead several times on
> L2CAP.

this one should go in first. Please prepare a version where this applies
cleanly to bluetooth-testing.git and let us push that one.

Regards

Marcel


