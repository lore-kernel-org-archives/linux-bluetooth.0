Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMv5Gbej-i+sTgQQBMyRS+7=JGCz66bDzn27UdMYuGtP3CQOLg@mail.gmail.com>
References: <1405718037-15401-1-git-send-email-armansito@chromium.org>
	<1405718037-15401-3-git-send-email-armansito@chromium.org>
	<CAMv5Gbej-i+sTgQQBMyRS+7=JGCz66bDzn27UdMYuGtP3CQOLg@mail.gmail.com>
Date: Mon, 21 Jul 2014 15:15:09 -0700
Message-ID: <CAHrH25RbkVThQDpzxSvPVWJEbC1BgcG3RqXuLC7c0Jt77w0mUg@mail.gmail.com>
Subject: Re: [PATCH 02/11] shared/gatt: Implement bt_gatt_exchange_mtu.
From: Arman Uguray <armansito@chromium.org>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

> Would it be better to include att and client_rx_mtu check in one "if"
> statement ? (both of them return false)
>

You're right, that sounds better.
