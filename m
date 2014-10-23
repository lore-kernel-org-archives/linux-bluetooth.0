Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Add new method - service discovery 
Date: Thu, 23 Oct 2014 10:21:13 -0700
Message-Id: <1414084874-24359-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This path enable usage of start service discovery method. Example usage:

Find all low energy devices advertising service with UUID 'abcd' and TxPower,  that have pathloss less than 60 dB
btmgmt find-service -u abcd -p 60 -l

Find all low energy devices advertising service with UUID 'abcd', and dont advertise TxPower and with RSSI over -50, or advertising TxPower and pathloss less than 60 dB
btmgmt find-service -u abcd -r -50 -p 60  -l


