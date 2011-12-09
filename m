Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Health Thermometer Profile patches
Date: Fri,  9 Dec 2011 19:18:58 +0100
Message-Id: <1323454744-14589-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a new set of patches wich implement most of the features in
HTP. GATT reconnections are the only missing feature up to now.

These patches depend on the patch:
att.h: Add client characteristic configuration bit fields

Changes include next patches:
[PATCH 1/6] thermometer.c: Implement SetProperty D-Bus method
[PATCH 2/6] thermometer.c: Confiure C.C.C descriptor during the
[PATCH 3/6] thermometer.c: Process measurement interval indications
[PATCH 4/6] thermometer.c: Fix possible null pointer deference
[PATCH 5/6] thermometer.c: Fix bad read operation when time stamp isn't provided
[PATCH 6/6] thermometer.c: Use system types instead of GLIB ones.
