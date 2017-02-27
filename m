Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Juha Kuikka <juha.kuikka@synapse.com>
To: linux-bluetooth@vger.kernel.org
Cc: juha.kuikka@gmail.com, luiz.dentz@gmail.com
Subject: [PATCH] hog: Destroy uHID device when disconnected
Date: Mon, 27 Feb 2017 14:40:26 -0800
Message-Id: <1488235227-27632-1-git-send-email-juha.kuikka@synapse.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

We discussed the persistence of the uHID object some time ago. I went ahead
and implemented this chance, making the uHID object follow the life time of the 
connection rather than the device.

Like you said, this may not be something you want to merge for other reasons, 
but since we need it, I figured I'd post it anyway since it might be useful
for someone else as well.

Thanks,
 - Juha
