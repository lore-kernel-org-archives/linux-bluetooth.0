Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/1] Bluetooth: Ack I-frames before retransmit missing
 packet
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
In-Reply-To: <1260915207-10338-1-git-send-email-gustavo@las.ic.unicamp.br>
References: <1260915207-10338-1-git-send-email-gustavo@las.ic.unicamp.br>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 17 Dec 2009 12:05:49 -0800
Message-Id: <1261080349.4041.46.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> Moving the Ack to before l2cap_retransmit_frame() we can avoid the case
> where txWindow is full and the packet can't be retransmited.

patch has been applied. Thanks.

Regards

Marcel


