Return-Path: <cyrus@holtmann.org>
Message-ID: <53AD4CF3.50806@message-id.googlemail.com>
Date: Fri, 27 Jun 2014 12:52:35 +0200
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] shared/queue: Fix invalid read
References: <1403866069-15394-1-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1403866069-15394-1-git-send-email-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

This also fixes my unit/test-queue failure.

Thanks!

Stefan

Am 27.06.2014 12:47, schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If the queue elements are destroyed by queue_destroy the head will point
> to freed memory causing the following error when unit/test-queue is run:
[...]
-- 
Stefan Seyfried
Linux Consultant & Developer -- GPG Key: 0x731B665B

B1 Systems GmbH
Osterfeldstraße 7 / 85088 Vohburg / http://www.b1-systems.de
GF: Ralph Dehner / Unternehmenssitz: Vohburg / AG: Ingolstadt,HRB 3537
