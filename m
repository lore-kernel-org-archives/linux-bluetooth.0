Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Future of plugins?
From: Travis Griggs <travisgriggs@gmail.com>
In-Reply-To: <1459256761-30554-1-git-send-email-hychao@chromium.org>
Date: Tue, 29 Mar 2016 11:16:22 -0700
Message-Id: <EEBBB242-AA83-4F75-B842-FF057EABEA6C@gmail.com>
References: <1459256761-30554-1-git-send-email-hychao@chromium.org>
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I’ve not had a lot of robust luck with the dbus/python approach to doing a custom peripheral.

I’m wondering if I’m barking up the wrong tree. Would I be served just as well to simply start from one or two of the plugins found in the profiles directory, and make my own? It’s a different API that I would have to reverse engineer from the source. But I wonder if it’s more reliable/vetted. It takes dbus out of the picture completely, which seems to be a lot of what is causing my confusion/frustration. Are these plugins going to stay in their current form? Or will they eventually transition to the dbus interface as well?