Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Health Thermometer Profile patches
Date: Tue, 22 Nov 2011 15:49:42 +0100
Message-Id: <1321973388-16300-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a new set of patches wich implement most of the features in
HTP. GATT reconnections are the only missing feature up to now.

[PATCH 1/6] Implement SetProperty D-Bus method
[PATCH 2/6] Confiure C.C.C descriptor during the thermometer configuration
[PATCH 3/6] Process measurements interval indication
[PATCH 4/6] Fix possible null pointer deference
[PATCH 5/6] Fix access to an invalid memory sector if time stamp is supported
[PATCH 6/6] Use system types instead of GLIB ones.
