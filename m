Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 0/3] Add HDP .register_application method
Date: Mon, 31 Mar 2014 12:46:58 +0300
Message-Id: <1396259221-2761-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v1: Fixes Szymon's comments(copy terminating character null
    also from HAL data(names, descriptions).

RFC: Due to limited IPC_MTU and variable length of
fields from 'bthl_reg_param_t *', it is difficult to put them
in single command and send though IPC. So we split this command
to multiple calls. First command will be called with opcode of
HAL_OP_HEALTH_REG_APP with 'struct hal_cmd_health_reg_app' data.
Later command will be called with opcode of
HAL_OP_HEALTH_MDEP with 'struct hal_cmd_health_mdep' data for
number_of_mdeps times. Daemon (android/health) side it will
process after it received all data and response will be sent
along with last call of HAL_OP_HEALTH_MDEP.

This avoids increasing value of IPC_MTU and mainly because of
optional parameters in 'bthl_reg_param_t'. Incase of unfilled
optional parameters, fixed size arrays in hal commands will be
empty.

Ravi kumar Veeramally (3):
  android/hal-ipc-api: Add extra command to Health HAL api document
  android/hal-msg: Add extra struct for mdep data
  android/hal-health: Add HDP .register_application method

 android/hal-health.c    | 88 ++++++++++++++++++++++++++++++++++++++++++++++++-
 android/hal-ipc-api.txt | 35 ++++++++++++--------
 android/hal-msg.h       | 37 ++++++++++-----------
 3 files changed, 127 insertions(+), 33 deletions(-)

-- 
1.8.3.2

