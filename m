Return-Path: <cyrus@holtmann.org>
From: ext-tommi.keisala@nokia.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix crash when GetProperties req is received before any adapters are set up
Date: Fri, 22 Oct 2010 13:32:37 +0300
Message-Id: <1287743558-17002-1-git-send-email-ext-tommi.keisala@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In-Reply-To: 


We have observed bluetoothd crashing on startup and I traced the issue being dict_append_array call with empty array but elements_n being 1.
