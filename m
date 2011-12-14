Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/7] Update mgmt interface to latest specification
Date: Wed, 14 Dec 2011 23:51:57 +0200
Message-Id: <1323899524-13653-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This patch set updates the kernel side implementation of the managment
interface to match the latest specification for it. This will break
support with any older user-space versions and you will need to use the
very latest user-space git to test it (where I just a minute ago pushed
matching patches).

Johan

