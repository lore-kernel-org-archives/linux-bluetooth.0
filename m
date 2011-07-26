Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Initial Health Thermometer Profile implementation
Date: Tue, 26 Jul 2011 14:15:51 +0200
Message-Id: <1311682554-21241-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The following patches don't require the previously submitted patches.

Adds the plugin and device driver for Health Thermometer Profile.
Not more functionality is added in these patches at the moment,
they are the starting point for the HTP implementation.

[PATCH 1/3] Initial support for Health Thermometer Profile (HTP)
[PATCH 2/3] Add manager files for HTP
[PATCH 3/3] Add thermometer driver skeleton

 Makefile.am               |    7 ++++
 acinclude.m4              |    6 ++++
 bootstrap-configure       |    1 +
 thermometer/main.c        |   62 ++++++++++++++++++++++++++++++++++++++
 thermometer/manager.c     |   72 +++++++++++++++++++++++++++++++++++++++++++++
 thermometer/manager.h     |   27 +++++++++++++++++
 thermometer/thermometer.c |   41 +++++++++++++++++++++++++
 thermometer/thermometer.h |   27 +++++++++++++++++
 8 files changed, 243 insertions(+), 0 deletions(-)

