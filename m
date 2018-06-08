Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d3db0bf5-1498-054e-7d57-54590897a1cb@gmail.com>
References: <d3db0bf5-1498-054e-7d57-54590897a1cb@gmail.com>
From: Unnamed Coder <wvqcoder@gmail.com>
Date: Fri, 8 Jun 2018 21:31:35 +0530
Message-ID: <CAEFqgm-pTQtxu+Bhn1kTLF-OaDwcDFS1ungZoWw4Vk+oQhO+bw@mail.gmail.com>
Subject: Fwd: regarding the API bt_hci_new_user_channel
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

I am a newbie wrt bluez. Therefore, please forgive the naivete.

The api bt_hci_new_user_channel opens a new socket every time it is
called. Is this understanding correct?

Within the same process, would we really need multiple instances of
this socket? Would just one not suffice?

Thank you and Best regards
@wvqc
