Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Anchit Narang <anchit.n@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, sachin.dev@samsung.com,
	anupam.r@smsung.com
Subject: Re: [PATCH] android/tester-main.c:Fixed Memory leak
Date: Tue, 21 Jul 2015 14:25:52 +0200
Message-ID: <2450618.Dt4JL0Yfvb@leonov>
In-Reply-To: <1437480881-20353-1-git-send-email-anchit.n@samsung.com>
References: <1437480881-20353-1-git-send-email-anchit.n@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anchit,

On Tuesday 21 of July 2015 17:44:41 Anchit Narang wrote:
> Ping

I looks like I never got the original patch. Could you resend it?

> >------- Original Message -------
> >Sender : Anchit Narang<anchit.n@samsung.com> Senior Software Engineer
> >(2)/SRI-Delhi-SWC Group/Samsung Electronics Date : Jun 23, 2015 14:54
> >(GMT+05:30)
> >Title : [PATCH] android/tester-main.c : Fixed Memory leak
> >
> >This patch fixes memory leak issues in various functions
> >by allocating memory to  structure step only after intial
> >checks are performed as control was returning from these
> >checks without freeing memory allocated to it.
> >---
> >
> > android/tester-main.c |   36 +++++++++++++++++++++++++++---------
> > 1 file changed, 27 insertions(+), 9 deletions(-)
> >
> >diff --git a/android/tester-main.c b/android/tester-main.c
> >index 19400fc..3a55792 100644
> >--- a/android/tester-main.c
> >+++ b/android/tester-main.c
> >@@ -329,7 +329,7 @@ static void mgmt_debug(const char *str, void
> >*user_data)>
> > static bool hciemu_post_encr_hook(const void *data, uint16_t len,
> > 
> > 							void *user_data)
> > 
> > {
> >
> >-	struct step *step = g_new0(struct step, 1);
> >+	struct step *step;
> >
> >		/*
> >		
> > 	 * Expected data: status (1 octet) + conn. handle (2 octets) +
> >
> >@@ -338,6 +338,8 @@ static bool hciemu_post_encr_hook(const void *data,
> >uint16_t len,>
> > 	if (len < 4)
> > 	
> > 		return true;
> >
> >+	step = g_new0(struct step, 1);
> >+
> >

I'm not sure if this is like this in original patch or due to citing but make 
sure you don't introduce double new lines in code (same for other places in 
this patch).

> > 	step->callback = ((uint8_t *)data)[3] ? CB_EMU_ENCRYPTION_ENABLED :
> > 						CB_EMU_ENCRYPTION_DISABLED;
> >
> >@@ -2961,13 +2963,15 @@ void emu_add_rfcomm_server_action(void)
> >
> > 	struct step *current_data_step = queue_peek_head(data->steps);
> > 	struct bt_action_data *rfcomm_data = current_data_step->set_data;
> > 	struct bthost *bthost;
> >
> >-	struct step *step = g_new0(struct step, 1);
> >+	struct step *step;
> >
> > 	if (!rfcomm_data) {
> > 	
> > 		tester_warn("Invalid l2cap_data params");
> > 		return;
> > 	
> > 	}
> >
> >+	step = g_new0(struct step, 1);
> >+
> >
> > 	bthost = hciemu_client_get_host(data->hciemu);
> > 	
> > 	bthost_add_rfcomm_server(bthost, rfcomm_data->channel,
> >
> >@@ -3010,7 +3014,7 @@ void bluetooth_disable_action(void)
> >
> > void bt_set_property_action(void)
> > {
> > 
> > 	struct test_data *data = tester_get_data();
> >
> >-	struct step *step = g_new0(struct step, 1);
> >+	struct step *step;
> >
> > 	struct step *current_data_step = queue_peek_head(data->steps);
> > 	bt_property_t *prop;
> >
> >@@ -3020,6 +3024,8 @@ void bt_set_property_action(void)
> >
> > 		return;
> > 	
> > 	}
> >
> >+	step = g_new0(struct step, 1);
> >+
> >
> > 	prop = (bt_property_t *)current_data_step->set_data;
> > 	
> > 	step->action_status = data->if_bluetooth->set_adapter_property(prop);
> >
> >@@ -3030,7 +3036,7 @@ void bt_set_property_action(void)
> >
> > void bt_get_property_action(void)
> > {
> > 
> > 	struct test_data *data = tester_get_data();
> >
> >-	struct step *step = g_new0(struct step, 1);
> >+	struct step *step;
> >
> > 	struct step *current_data_step = queue_peek_head(data->steps);
> > 	bt_property_t *prop;
> >
> >@@ -3040,6 +3046,8 @@ void bt_get_property_action(void)
> >
> > 		return;
> > 	
> > 	}
> >
> >+	step = g_new0(struct step, 1);
> >+
> >
> > 	prop = (bt_property_t *)current_data_step->set_data;
> > 	
> > 	step->action_status = data->if_bluetooth->get_adapter_property(
> >
> >@@ -3072,7 +3080,7 @@ void bt_get_device_props_action(void)
> >
> > {
> > 
> > 	struct test_data *data = tester_get_data();
> > 	struct step *current_data_step = queue_peek_head(data->steps);
> >
> >-	struct step *step = g_new0(struct step, 1);
> >+	struct step *step;
> >
> > 	if (!current_data_step->set_data) {
> > 	
> > 		tester_debug("bdaddr not defined");
> >
> >@@ -3080,6 +3088,8 @@ void bt_get_device_props_action(void)
> >
> > 		return;
> > 	
> > 	}
> >
> >+	step = g_new0(struct step, 1);
> >+
> >
> > 	step->action_status =
> > 	
> > 		data->if_bluetooth->get_remote_device_properties(
> > 		
> > 						current_data_step->set_data);
> >
> >@@ -3092,7 +3102,7 @@ void bt_get_device_prop_action(void)
> >
> > 	struct test_data *data = tester_get_data();
> > 	struct step *current_data_step = queue_peek_head(data->steps);
> > 	struct bt_action_data *action_data = current_data_step->set_data;
> >
> >-	struct step *step = g_new0(struct step, 1);
> >+	struct step *step;
> >
> > 	if (!action_data) {
> > 	
> > 		tester_warn("No arguments for 'get remote device prop' req.");
> >
> >@@ -3100,6 +3110,8 @@ void bt_get_device_prop_action(void)
> >
> > 		return;
> > 	
> > 	}
> >
> >+	step = g_new0(struct step, 1);
> >+
> >
> > 	step->action_status = data->if_bluetooth->get_remote_device_property(
> > 	
> > 							action_data->addr,
> > 							action_data->prop_type);
> >
> >@@ -3112,7 +3124,7 @@ void bt_set_device_prop_action(void)
> >
> > 	struct test_data *data = tester_get_data();
> > 	struct step *current_data_step = queue_peek_head(data->steps);
> > 	struct bt_action_data *action_data = current_data_step->set_data;
> >
> >-	struct step *step = g_new0(struct step, 1);
> >+	struct step *step;
> >
> > 	if (!action_data) {
> > 	
> > 		tester_warn("No arguments for 'set remote device prop' req.");
> >
> >@@ -3120,6 +3132,8 @@ void bt_set_device_prop_action(void)
> >
> > 		return;
> > 	
> > 	}
> >
> >+	step = g_new0(struct step, 1);
> >+
> >
> > 	step->action_status = data->if_bluetooth->set_remote_device_property(
> > 	
> > 							action_data->addr,
> > 							action_data->prop);
> >
> >@@ -3132,7 +3146,7 @@ void bt_create_bond_action(void)
> >
> > 	struct test_data *data = tester_get_data();
> > 	struct step *current_data_step = queue_peek_head(data->steps);
> > 	struct bt_action_data *action_data = current_data_step->set_data;
> >
> >-	struct step *step = g_new0(struct step, 1);
> >+	struct step *step;
> >
> > 	if (!action_data || !action_data->addr) {
> > 	
> > 		tester_warn("Bad arguments for 'create bond' req.");
> >
> >@@ -3140,6 +3154,8 @@ void bt_create_bond_action(void)
> >
> > 		return;
> > 	
> > 	}
> >
> >+	step = g_new0(struct step, 1);
> >+
> >
> > 	step->action_status =
> > 	
> > 			data->if_bluetooth->create_bond(action_data->addr,
> > 			
> > 						action_data->transport_type ?
> >
> >@@ -3154,7 +3170,7 @@ void bt_pin_reply_accept_action(void)
> >
> > 	struct test_data *data = tester_get_data();
> > 	struct step *current_data_step = queue_peek_head(data->steps);
> > 	struct bt_action_data *action_data = current_data_step->set_data;
> >
> >-	struct step *step = g_new0(struct step, 1);
> >+	struct step *step;
> >
> > 	if (!action_data || !action_data->addr || !action_data->pin) {
> > 	
> > 		tester_warn("Bad arguments for 'pin reply' req.");
> >
> >@@ -3162,6 +3178,8 @@ void bt_pin_reply_accept_action(void)
> >
> > 		return;
> > 	
> > 	}
> >
> >+	step = g_new0(struct step, 1);
> >+
> >
> > 	step->action_status = data->if_bluetooth->pin_reply(action_data->addr,
> > 	
> > 							TRUE,
> > 							action_data->pin_len,
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
BR
Szymon Janc
