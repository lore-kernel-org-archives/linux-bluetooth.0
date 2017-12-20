Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 20 Dec 2017 15:05:45 +0100
From: Johan Hedberg <johan.hedberg@gmail.com>
To: sbrown@cortland.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] mesh: Add subscriptions to node structure and json
 database
Message-ID: <20171220140545.GA12891@x1c>
References: <20171220131008.10640-1-sbrown@cortland.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171220131008.10640-1-sbrown@cortland.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steve,

On Wed, Dec 20, 2017, sbrown@cortland.com wrote:
>  mesh/config-client.c | 27 +++++++++++++++++-----
>  mesh/node.c          | 22 ++++++++++++++++++
>  mesh/node.h          |  2 ++
>  mesh/prov-db.c       | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  mesh/prov-db.h       |  2 ++
>  5 files changed, 110 insertions(+), 6 deletions(-)

Just a couple of coding style comments:

> +bool node_add_subscription(struct mesh_node *node, uint8_t ele_idx,
> +			uint32_t model_id, uint16_t addr)
> +{
> +	struct mesh_model *model;
> +	GList *l;
> +
> +	model = get_model(node, ele_idx, model_id);
> +
> +	if(!model)

Missing space after if, and remove the empty line before it (in general
no empty line between assigning to a variable and testing its value).

> +	l = g_list_find(model->subscriptions, GUINT_TO_POINTER(addr));
> +
> +	if (l)

Same thing here with the empty line

> +bool prov_db_add_subscription(struct mesh_node *node, uint8_t ele_idx,
> +			uint32_t model_id, uint16_t addr)
> +{
> +	json_object *jmain;
> +	json_object *jmodel;
> +	json_object *jsubscriptions = NULL;
> +	bool local = (node == node_get_local_node());

Rather minor, but the generally preferred aestethic with variable
declarations is "reverse xmas tree", i.e. longest ones first.

> +	jmodel = get_jmodel_obj(node, ele_idx, model_id, &jmain);
> +
> +	if (!jmodel)

Same thing as earlier with the empty line.

Otherwise looks fine to me.

Johan
