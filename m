Return-Path: <johan.hedberg@gmail.com>
Date: Tue, 24 Jul 2018 09:42:15 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: Re: [PATCH BlueZ v1 0/7] Add BREDR PHYs in PHY configuration commands
Message-ID: <20180724064215.GA30169@x1c.home>
References: <1531999447-3479-1-git-send-email-jaganathx.kanakkassery@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1531999447-3479-1-git-send-email-jaganathx.kanakkassery@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Thu, Jul 19, 2018, Jaganath Kanakkassery wrote:
> Jaganath Kanakkassery (7):
>   monitor: Add BREDR PHYs in PHY configuration commands
>   emulator: Add BREDR 2M & 3M, 3 & 5 Slot packet type support
>   mgmt-tester: Add extended advertising test cases
>   mgmt-tester: Add PHY Configuration test cases
>   mgmt-tester: Add tests for extended scanning and device found
>   mgmt-tester: Add support ext create connection and enh conn complete
>   mgmt-tester: Update Supported_settings to reflect PHY_CONFIGURATION
> 
>  emulator/btdev.c    |   10 +
>  monitor/packet.c    |   39 +-
>  tools/mgmt-tester.c | 2268 ++++++++++++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 2200 insertions(+), 117 deletions(-)

I get a bunch of errors when trying to build this set:

  CC       tools/mgmt-tester.o
tools/mgmt-tester.c:7839:36: error: ‘add_ext_advertising_mgmt_cmd_arr’ defined but not used [-Werror=unused-const-variable=]
 static const struct setup_mgmt_cmd add_ext_advertising_mgmt_cmd_arr[] = {
                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/mgmt-tester.c:7826:22: error: ‘add_ext_advertising_param_name_data_appear’ defined but not used [-Werror=unused-const-variable=]
 static const uint8_t add_ext_advertising_param_name_data_appear[] = {
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/mgmt-tester.c:7800:22: error: ‘add_ext_advertising_param_name_data_inv’ defined but not used [-Werror=unused-const-variable=]
 static const uint8_t add_ext_advertising_param_name_data_inv[] = {
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/mgmt-tester.c:7755:22: error: ‘add_ext_advertising_param_name_data_ok’ defined but not used [-Werror=unused-const-variable=]
 static const uint8_t add_ext_advertising_param_name_data_ok[] = {
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/mgmt-tester.c:7740:22: error: ‘set_ext_scan_rsp_data_short_name_fits’ defined but not used [-Werror=unused-const-variable=]
 static const uint8_t set_ext_scan_rsp_data_short_name_fits[] = {
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/mgmt-tester.c:7672:22: error: ‘add_ext_advertising_param_name’ defined but not used [-Werror=unused-const-variable=]
 static const uint8_t add_ext_advertising_param_name[] = {
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/mgmt-tester.c:7636:22: error: ‘add_ext_advertising_empty_param’ defined but not used [-Werror=unused-const-variable=]
 static const uint8_t add_ext_advertising_empty_param[] = {
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/mgmt-tester.c:7614:22: error: ‘add_ext_advertising_param_scrsp_appear_null’ defined but not used [-Werror=unused-const-variable=]
 static const uint8_t add_ext_advertising_param_scrsp_appear_null[] = {
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/mgmt-tester.c:7587:22: error: ‘add_ext_advertising_param_scrsp_appear_data_too_long’ defined but not used [-Werror=unused-const-variable=]
 static const uint8_t add_ext_advertising_param_scrsp_appear_data_too_long[] = {
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/mgmt-tester.c:7560:22: error: ‘add_ext_advertising_param_scrsp_appear_data_ok’ defined but not used [-Werror=unused-const-variable=]
 static const uint8_t add_ext_advertising_param_scrsp_appear_data_ok[] = {
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/mgmt-tester.c:7535:22: error: ‘add_ext_advertising_param_scrsp_data_only_too_long’ defined but not used [-Werror=unused-const-variable=]
 static const uint8_t add_ext_advertising_param_scrsp_data_only_too_long[] = {
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/mgmt-tester.c:7510:22: error: ‘add_ext_advertising_param_scrsp_data_only_ok’ defined but not used [-Werror=unused-const-variable=]
 static const uint8_t add_ext_advertising_param_scrsp_data_only_ok[] = {
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/mgmt-tester.c:7488:22: error: ‘add_ext_advertising_param_empty’ defined but not used [-Werror=unused-const-variable=]
 static const uint8_t add_ext_advertising_param_empty[] = {
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/mgmt-tester.c:7364:34: error: ‘add_ext_advertising_power_off’ defined but not used [-Werror=unused-const-variable=]
 static const struct generic_data add_ext_advertising_power_off = {
                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/mgmt-tester.c:6992:19: error: ‘set_powered_ext_adv_instance_settings_param’ defined but not used [-Werror=unused-const-variable=]
 static const char set_powered_ext_adv_instance_settings_param[] = {
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Johan
